# frozen_string_literal: true

module RuboCop
  module Cop
    module Spbtv
      # Prefer validating one attribute at once.
      #
      # @example
      #   @bad
      #   validates :name, :age, presence: true
      #
      #   @good
      #   validates :age, presence: true
      #   validates :name, presence: true
      #
      class MultipleValidation < Cop
        include RuboCop::Cop::AutocorrectLogic

        MSG = 'Prefer validating one attribute at once.'.freeze

        def on_send(node)
          _, _, *args = *node
          add_offense(node, location: :selector, message: MSG) if node.command?(:validates) && args.length > 2
        end

        def autocorrect(node)
          _receiver, method_name, *args = *node
          *attributes, options = args

          multiline_replacement = attributes.map do |attribute|
            "#{method_name} #{attribute.source}, #{options.source}"
          end

          lambda do |corrector|
            corrector.replace(node.source_range, multiline_replacement.sort.join("\n"))
          end
        end
      end
    end
  end
end
