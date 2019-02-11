# frozen_string_literal: true

module RuboCop
  module Cop
    module Spbtv
      module Postgres
        # Do not add a NOT NULL column.
        #
        # This will have the same problem, as “Add a column with a default”.
        # To make this operation without locking, you can create a new table
        # with the addition of the non-nullable column, write to both tables,
        # backfill, and then switch to the new table. This workaround is
        # incredibly onerous and need two times more space than is a table takes.
        #
        # @example
        #   @bad
        #   add_column :users, :name, :string, null: false
        #
        #   @good
        #   add_column :users, :name, :string
        #
        class AddColumnWithNotNull < Cop
          MSG = 'Do not add a NOT NULL column.'.freeze

          def_node_matcher :add_not_null_column?, <<-PATTERN
            (send _ :add_column _ _ _ (hash $...))
          PATTERN

          def_node_matcher :null_false?, <<-PATTERN
            (pair (sym :null) (false))
          PATTERN

          def on_send(node)
            pairs = add_not_null_column?(node)
            return unless pairs

            null_false = pairs.detect { |pair| null_false?(pair) }
            return unless null_false

            add_offense(null_false, location: :expression)
          end
        end
      end
    end
  end
end
