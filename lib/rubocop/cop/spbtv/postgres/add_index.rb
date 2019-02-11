# frozen_string_literal: true

module RuboCop
  module Cop
    module Spbtv
      module Postgres
        # Do not add an index.
        #
        # Normally PostgreSQL locks the table to be indexed against writes and performs
        # the entire index build with a single scan of the table. Other transactions
        # can still read the table, but not to insert, update, or delete rows until
        # the index build is finished.
        #
        # To overcome this issue you may specify the CONCURRENTLY option of CREATE INDEX.
        # When this option is used, PostgreSQL must perform two scans of the table, and in
        # addition it must wait for all existing transactions that could potentially
        # modify or use the index to terminate.
        #
        # If a problem arises while scanning the table, such as a uniqueness violation
        # in a unique index, the CREATE INDEX command will fail but leave behind an
        # “invalid” index.
        #
        # The recommended recovery method in such cases is to drop the index and
        # try again to perform CREATE INDEX CONCURRENTLY.
        #
        # Another difference is that a regular CREATE INDEX command can be performed
        # within a transaction block, but CREATE INDEX CONCURRENTLY cannot.
        #
        # @see https://www.postgresql.org/docs/9.2/static/sql-createindex.html#SQL-CREATEINDEX-CONCURRENTLY
        # @see https://robots.thoughtbot.com/how-to-create-postgres-indexes-concurrently-in
        #
        # @example
        #   @bad
        #   class AddIndexToAsksActive < ActiveRecord::Migration
        #     def change
        #       add_index :asks, :active
        #     end
        #   end
        #
        #   @good
        #   class AddIndexToAsksActive < ActiveRecord::Migration
        #     disable_ddl_transaction!
        #     def change
        #       add_index :asks, :active, algorithm: :concurrently
        #     end
        #   end
        #
        class AddIndex < Cop
          MSG = 'Do not add an index.'.freeze

          def_node_search :disable_ddl_transaction?, '(send _ :disable_ddl_transaction!)'

          def_node_matcher :add_index_without_options?, <<-PATTERN
            (send _ :add_index _ _)
          PATTERN

          def_node_matcher :add_index_with_options?, <<-PATTERN
            (send _ :add_index _ _ (hash $...))
          PATTERN

          def_node_matcher :concurrently?, <<-PATTERN
            (pair (sym :algorithm) (sym :concurrently))
          PATTERN

          def on_class(node)
            @disable_ddl_transaction = disable_ddl_transaction?(node)
          end

          def on_send(node)
            if add_index_without_options?(node)
              add_offense(node, location: :expression)
            elsif (options = add_index_with_options?(node))
              has_concurrently = options.detect { |pair| concurrently?(pair) }
              add_offense(node, location: :expression) unless has_concurrently && @disable_ddl_transaction
            end
          end
        end
      end
    end
  end
end
