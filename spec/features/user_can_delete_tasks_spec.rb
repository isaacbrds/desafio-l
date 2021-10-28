require 'rails_helper'

feature 'User can Delete Tasks' do
  scenario 'Successfully' do
    user = create(:user)
    profile = create(:profile, user: user)
    task = create(:task, user: user, status: 'complete')
    
    login_as(user)

    visit tasks_path
    click_link 'Task Board'
    expect(current_path).to eq(tasks_path)
    click_link 'Delete'

    expect(current_path).to eq(tasks_path)
    expect(page).to_not have_text(task.title)
  end

  scenario 'And Must be loged in' do
    user = create(:user)
    profile = create(:profile, user: user)
    task = create(:task, user: user, status: 'complete')
    
    visit root_path
    expect(page).to_not have_text('Task Board')
    
    expect(current_path).to eq(root_path)
  end 
end
