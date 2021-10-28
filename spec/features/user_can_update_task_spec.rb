require 'rails_helper'

feature 'User can edit Tasks' do
  scenario 'Successfully' do
    user = create(:user)
    profile = create(:profile, user: user)
    task = create(:task, user: user, status: 'complete')
    
    login_as(user)

    visit tasks_path
    click_link 'Task Board'
    expect(current_path).to eq(tasks_path)
    click_link 'Edit'
    expect(page).to have_content("Edit task")
       

    fill_in "Title", with: "Task sendo editada"
    
    click_on "Update Task"

    expect(current_path).to eq(tasks_path)
    expect(page).to have_text("Task sendo editada")
  end 

  scenario 'And must fill all fields' do
    user = create(:user)
    profile = create(:profile, user: user)
    task = create(:task, user: user, status: 'complete')
    
    login_as(user)

    visit tasks_path
    click_link 'Task Board'
    expect(current_path).to eq(tasks_path)
    click_link 'Edit'
    expect(page).to have_content("Edit task")
       
    fill_in "Title", with: ""
    click_on "Update Task"

    expect(page).to have_text("Title is too short (minimum is 4 characters)")
    
  end
end
