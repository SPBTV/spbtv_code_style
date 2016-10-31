# frozen_string_literal: true

module RuboCop
  module Cop
    module Spbtv
      module Postgres
        # Do not change column.
        #
        # It is not strictly unsafe for all changes. Changing the
        # length of a varchar, for example, does not lock a table.
        # But if column type change requires a rewrite or not depends
        # on the datatype, in this case this operation requires updating
        # each row of the table. As workaround, you can add a new column
        # with needed type, change the code to write to both columns,
        # and backfill the new column.
        #
        # @example
        #   @bad
        #   change_column :suppliers, :name, :string, limit: 80
        #
        class ChangeColumn < Cop
          MSG = 'Do not change column.'.freeze

          def on_send(node)
            _, _, * = *node
            if node.command?(:change_column)
              add_offense(node, :selector, MSG)
            end
          end
        end
      end
    end
  end
end
