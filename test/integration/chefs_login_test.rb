require 'test_helper'

class ChefsLoginTest < ActionDispatch::IntegrationTest
   def setup()
     @chef = Chef.create!(name:"mashrur",email:"csosa@exam.com",password:"password")
   end
   
   test "invalid login is rejected " do
     get login_path
     assert_template 'sessions/new'
     post login_path, params: {session: {email:"", password:""}}
     assert_template 'sessions/new'
     assert_not flash.empty?
     get root_path
     assert flash.empty?
   end
   
   test "valid login credentials accepted and begin session" do
       get login_path
       assert_template 'sessions/new'
       post login_path, params: {session:{email:@chef.email, password: @chef.password }}
       assert_redirected_to @chef
       follow_redirect!
       assert_template 'chefs/show'
       assert_not flash.empty?
   end
   
end
