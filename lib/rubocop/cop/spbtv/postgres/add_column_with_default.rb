# frozen_string_literal: true

module RuboCop
  module Cop
    module Spbtv
      module Postgres
        # Do not add a column with a default value.
        #
        # Adding a column with a default requires updating each row of the table (to store
        # the new column value). For big table this will create long running operation
        # that locks it.
        #
        # So if you intend to fill the column with mostly non default values,
        # it’s best to add the column with no default, insert the correct values
        # using UPDATE (correct way is to do batched updates, for example,
        # update 1000 rows at a time, because big update will create table-wide lock),
        # and then add any desired default.
        #
        # @example
        #   @bad
        #   add_column :users, :name, :string, default: "Peter"
        #
        #   @good
        #   add_column :users, :name, :string
        #   User.find_in_batches do |batch|
        #     batch.update_all(name: 'Peter')
        #   end
        #
        class AddColumnWithDefault < Cop
          MSG = 'Do not add a column with a default value.'.freeze

          def_node_matcher :add_column_with_default?, <<-PATTERN
            (send _ :add_column _ _ _ (hash $...))
          PATTERN

          def_node_matcher :has_default?, <<-PATTERN
            (pair (sym :default) !(:nil))
          PATTERN

          def on_send(node)
            pairs = add_column_with_default?(node)
            return unless pairs

            has_default = pairs.detect { |pair| has_default?(pair) }

            return unless has_default

            add_offense(has_default, location: :expression)
          end
        end
      end
    end
  end
end
