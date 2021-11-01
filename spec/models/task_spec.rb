require 'rails_helper'

RSpec.describe Task, type: :model do
  it 'Is created with default share status nil' do
    expect(Task.new.share).to eq nil
  end

  it 'Is created with default \'status\' value of 0' do
    expect(Task.new.status.to_i).to eq 0
  end

  it 'Is created with default priority of 0' do
    expect(Task.new.priority.to_i).to eq 0
  end

  it "is not valid without a title" do
    task = Task.new(title: nil)
    expect(task).to_not be_valid
  end

  it "is not valid with a title at least 4 characters" do
    task = Task.new(title: 'nil')
    expect(task).to_not be_valid
  end

  it "is not valid if a title has 21 characters" do
    task = Task.new(title: 'niloaoaoaodjjdjdjdhdkakakakaajkakqiouri')
    expect(task).to_not be_valid
  end
  
  it "is not valid without a description at least 4 characters" do
    task = Task.new(description: 'nil')
    expect(task).to_not be_valid
  end

  it "is not valid without a description" do
    task = Task.new(description: nil)
    expect(task).to_not be_valid
  end

  it "is not if a description has 21 characters" do
    task = Task.new(description: 'this is a description to tasks but it is very long')
    expect(task).to_not be_valid
  end

  it "is not if a task hasn\'t a user" do
    task = Task.new(user: nil)
    expect(task).to_not be_valid
  end
end

