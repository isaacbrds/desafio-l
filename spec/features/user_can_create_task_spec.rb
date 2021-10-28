require 'rails_helper'

feature 'User can Create Task' do
  scenario 'Successfully' do
    user = create(:user)
    profile = create(:profile, user: user)
    
    login_as(user)

    visit root_path
    click_link 'Create a Task'
    expect(current_path).to eq(new_task_path)
    expect(page).to have_content("New task")

    fill_in "Title", with: "Task nova sendo criada"
    fill_in "Task's Description", with: "Descrição da task marota criada!"
    
    click_on "Create Task"

    expect(current_path).to eq(tasks_path)
    
  end

  scenario 'And must be loged in' do
    user = create(:user)
    profile = create(:profile, user: user)
    
    visit root_path
    expect(page).to_not have_text('Create Task')
    expect(current_path).to eq(root_path)
    
  end

  scenario 'And Title must have more than 4 characters' do

    user = create(:user)
    profile = create(:profile, user: user)
    
    login_as(user)

    visit root_path
    click_link 'Create a Task'
    expect(current_path).to eq(new_task_path)
    expect(page).to have_content("New task")

    
    fill_in "Title", with: "Des"
    fill_in "Task's Description", with: "Descrição da task marota criada!"
    
    click_on "Create Task"

    expect(page).to have_content("Title is too short (minimum is 4 characters)")
  end

  scenario 'And Title must have less than 20 characters' do

    user = create(:user)
    profile = create(:profile, user: user)
    
    login_as(user)

    visit root_path
    click_link 'Create a Task'
    expect(current_path).to eq(new_task_path)
    expect(page).to have_content("New task")

    
    fill_in "Title", with: "Descrição da task marota criada!"
    fill_in "Task's Description", with: "Descrição da task marota criada!"
    
    click_on "Create Task"

    expect(page).to have_content("Title is too long (maximum is 20 characters)")
  end 

  scenario 'And Description Can\'t be blank' do 
    user = create(:user)
    profile = create(:profile, user: user)
    
    login_as(user)

    visit root_path
    click_link 'Create a Task'
    expect(current_path).to eq(new_task_path)
    expect(page).to have_content("New task")

    
    fill_in "Title", with: "Task #1"
    
    
    click_on "Create Task"

    expect(page).to have_content("Description can't be blank")
  end
end

