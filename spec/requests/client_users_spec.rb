require 'rails_helper'

RSpec.describe "/tasks", type: :request do 
    
    before(:each) do
        @current_user = create(:user)
        profile = create(:profile, user: @current_user)
        sign_in(@current_user)
    end

    
    describe "GET /tasks" do
        
        let(:url) { "/tasks/"}
        let!(:tasks) {create_list(:task, 6, user: @current_user, status: 'complete')}
        it "renders a successful response" do 
            get url
            expect(response).to be_truthy
            expect(response.status).to eq(200)
        end
    end 
    describe "GET /show" do
        let(:task) {create(:task, user: @current_user, status: 'complete')}
        let(:url) { "/tasks/#{task.id}"}
        it "renders a successful response" do
          get url
          expect(response).to be_successful
        end
    end
    describe "GET /new" do
        let(:url) { "/tasks/new"}
        it "renders a successful response" do
          get url
          expect(response).to be_successful
        end
    end

    describe "POST /tasks" do
        
        context "with valid parameters" do

            before(:each) do
                @task_attributes = attributes_for(:task)
                post tasks_url,params: {task: @task_attributes, user: @current_user}
            end

            it "Redirect to new task" do
                expect(response).to have_http_status(302)
                expect(response.body).to redirect_to(tasks_url)
            end

            it "Create task with right attributes" do
                expect(Task.last.title).to eql(@task_attributes[:title])            
            end
        end
        
        context "with invalid parameters" do
            before(:each) do
                @task_attributes = attributes_for(:task, title: nil)
                post tasks_url, params: {task: @task_attributes}
            end
            it "No redirect" do
                expect(response).to have_http_status(200)
                expect(response.body).to include('title')
            end

            it "does not create a new task" do
                expect {
                  post tasks_url, params: { task:  @task_attributes }
                }.to change(Task, :count).by(0)
              end
        end
      end



    describe "GET /edit" do
        let!(:task){ create(:task, user: @current_user) }
        let(:url) { "/tasks/#{task.id}/edit"}
           

        it "render a successful response" do
            get url
            expect(response).to be_successful
        end
    end

    describe "PATCH /tasks" do
        context "with valid parameters" do
            before(:each) do
                task = create(:task, user: @current_user)
                @new_task_attributes = attributes_for(:task)
                
                patch "/tasks/#{task.id}", params: {task: @new_task_attributes}
            end
        
            it "returns http success" do
                expect(response).to have_http_status(302)
            end
    
            it "Task have the new attributes" do
                expect(Task.last.title).to eq(@new_task_attributes[:title])
            end
        end

        context "with invalid parameters" do
            before(:each) do
                task = create(:task, user: @current_user)
                @new_task_attributes = attributes_for(:task, title: nil)
                put task_url(task), params: {task: @new_task_attributes}
            end
        
            it "returns http success" do
                expect(response).to have_http_status(200)
            end
    
            it "User have the new attributes" do
                expect(Task.last.title).to_not eq(@new_task_attributes[:title])
            end
        end
    end

    describe "DESTROY /posts" do 
        let!(:task){ create(:task, user: @current_user) }
        let(:url) { "/tasks/#{task.id}"}
        it "removes post" do 
            expect do 
                delete url
            end.to change(Task, :count).by(-1)
        end

        it 'returns success status' do
            delete url
            expect(response).to have_http_status(302)
        end
    end
end