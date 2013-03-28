Given /^there is a verified group request$/ do
  @group_request = FactoryGirl.create(:group_request)
  @group_request.verify!
end

Given /^I am a logged in site admin$/ do
  @site_admin = FactoryGirl.create :user, :is_admin => true
  login_automatically @site_admin
end

When /^I approve the group request and send the setup invitation$/ do
  @setup_group = SetupGroup.new(@group_request)
  @group = @setup_group.approve_group_request!(approved_by: @site_admin)

  @invitation = CreateInvitation.to_start_group!(group: @group,
                                                 inviter: @site_admin,
                                                 recipient_email: @group_request.admin_email)


  @setup_group.send_invitation_to_start_group!(invitation: @invitation,
                                               message_body: 'We woud love to! {invitation_link}')
end

Then /^the requestor should get an invitation to start a loomio group$/ do
  open_email(@group_request.admin_email)
  current_email.should have_content(invitation_path(@invitation))
  current_email.should have_content(@invitation.token)
end

Given /^an invitiation to start a loomio group has been sent$/ do
  @group_request = FactoryGirl.create(:group_request)
  @group_request.verify!
  @site_admin = FactoryGirl.create :user, :is_admin => true
  @setup_group = SetupGroup.new(@group_request)
  @group = @setup_group.approve_group_request!(approved_by: @site_admin)
  @invitation = CreateInvitation.to_start_group!(group: @group,
                                                 inviter: @site_admin,
                                                 recipient_email: @group_request.admin_email)
  @setup_group.send_invitation_to_start_group!(invitation: @invitation,
                                               message_body: 'We woud love to! {invitation_link}')
end

When /^the user clicks the invitiation link$/ do
  email = ActionMailer::Base.deliveries.last
  url = email.body.match(/https?:\/\/[\S]+/)[0]
  path = URI.parse(url).path
  puts path
  visit path
  save_and_open_page
end

When /^signs up as a new user$/ do

  within ".signup-form" do
    fill_in :name, with: 'Jimmy Jiminson'
    fill_in :email, with: 'jim@jiminson.com'
    fill_in :password, with: 'milkbottle'
    fill_in :password_confirmation, with: 'milkbottle'
    click_on 'Sign Up!'
  end
end

Then /^they should see the Start your Group wizard$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^I am a signed in admin of an unconfigured group$/ do
  pending # express the regexp above with the code you wish you had
end

When /^I visit the setup_new_group_wizard path$/ do
  pending # express the regexp above with the code you wish you had
end

When /^enter a group name and description$/ do
  pending # express the regexp above with the code you wish you had
end

When /^create a discussion and proposal$/ do
  pending # express the regexp above with the code you wish you had
end

When /^invite other users to join the group$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^the group should be configured$/ do
  pending # express the regexp above with the code you wish you had
end
