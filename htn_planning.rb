#! ruby -EUTF-8
# _*_ enfoding: utf-8 _*_

module HTNPlanning

  TaskTable = Struct.new( :primitives, :compounds )

  TaskSet = Struct.new( :taskName, :data )

  class Planner

    public

    def initialize
    end

    def plan( taskTable, planGenerater, state, tasksets )
      return plan_internal( taskTable, planGenerater, state, tasksets , [] )
    end

    private

    def plan_internal( taskTable, planGenerater, state, tasksets, plan )

      return if tasksets.empty?

      task = tasksets.shift

      if taskTable.primitives.has_key?( task.taskName )
        if taskTable.primitives[ task.taskName ].execute( state, task.data )
          plan << planGenerater.generate( PlanGenerater::Desc.new( task, state ) )
          plan_internal( taskTable, planGenerater, state, tasksets, plan )
        end
      elsif taskTable.compounds.has_key?( task.taskName )
        orders = taskTable.compounds[ task.taskName ].execute( state, task.data )
        if orders.empty? == false
          orders.each do |order|
            tasksets << order
            plan_internal( taskTable, planGenerater, state, tasksets, plan )
          end
        end
      end

      return plan
    end

  end

  class Task

    public

    def initialize
    end

    def execute( state, data )
      p "#{self.class} : execute"
      _execute( state, data )
    end

    private

    def _execute( state, data )
    end

  end

  class PlanGenerater

    Desc = Struct.new( :taskset, :state )

    def initialize
    end

    def generate( desc )
    end

  end

end # HTNPlanning

