#! ruby -EUTF-8
# _*_ enfoding: utf-8 _*_

require_relative "./field_task.rb"

begin

  primitives =
  {
    :attack     =>  HTNPlanning::Field::PrimitiveTask::Attack.new,
    :move       =>  HTNPlanning::Field::PrimitiveTask::Move.new,
    :search     =>  HTNPlanning::Field::PrimitiveTask::Search.new,
  }

  compounds =
  {
    :help       =>  HTNPlanning::Field::CompoundTask::Help.new,
  }

  TASK_TABLE = HTNPlanning::TaskTable.new( primitives, compounds )

  state = HTNPlanning::Field::State.new(
    "Cat",
    "Dog",
    "Fish",
    100,
    "",
    "Rock"
  )

  planGenerater = HTNPlanning::Field::PlanGenerater.new()

  planner = HTNPlanning::Planner.new()
  plan = planner.plan(
    TASK_TABLE,
    planGenerater,
    state,
    [ HTNPlanning::TaskSet.new( :help, HTNPlanning::Field::Data.new( state.target ) ) ]
  )

  p "----------"
  plan.each do |action|
    p action
  end

end

