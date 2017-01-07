#! ruby -EUTF-8
# _*_ enfoding: utf-8 _*_

require_relative "./../htn_planning.rb"

module HTNPlanning
module Field

  State = Struct.new( :self, :target, :nearEnemy, :distance, :item, :nearSearch )

  Data = Struct.new( :target )

  class PlanGenerater < HTNPlanning::PlanGenerater

    def initialize
    end

    def generate( desc )

      return "#{desc.taskset.taskName.to_s} : #{desc.state.target}"

    end

  end

  module PrimitiveTask

    class Attack < HTNPlanning::Task

      def initialize
      end

      def _execute( state, data )
        state.target = data.target
        return true
      end

    end

    class Move < HTNPlanning::Task

      def initialize
      end

      def _execute( state, data )
        state.target = data.target
        return true
      end

    end

    class Search < HTNPlanning::Task

      def initialize
      end

      def _execute( state, data )

        return if state.item.empty? == false

        state.target = data.target
        state.item = "reserve"
        return true
      end

    end

  end # PrimitiveTask

  module CompoundTask

    class Help < HTNPlanning::Task

      def initialize
      end

      def _execute( state, data )

        state.target = data.target

        ret = []

        if state.nearSearch.empty? == false
          ret << HTNPlanning::TaskSet.new( :search, Data.new( state.nearSearch ) )
        end

        if state.nearEnemy.empty? == false
          ret << HTNPlanning::TaskSet.new( :attack, Data.new( state.nearEnemy ) )
        end

        if state.distance > 50 
          ret << HTNPlanning::TaskSet.new( :move, Data.new( state.target ) )
        end

        return ret
      end

    end

  end # CompoundTask

end # Field
end # HTNPlanning

