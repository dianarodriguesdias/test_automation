# login steps
Given(/^the user navigates to QS demo homepage$/) do
  browser.navigate_movies!
end

When(/^a login is performed in QS demo$/) do
  browser.goto_login!
  if QAT[:scenario_tags].include? '@unsuccessful'
    username, password =
        QAT.configuration.dig(:users, :unsuccessful).values_at(:username, :password)
  else
    username, password =
        QAT.configuration.dig(:users, :successful).values_at(:username, :password)
  end
  browser.perform_login(username, password)
end

Then(/^Login is "([^"]*)"$/) do |login|
  if login.eql? 'successful'
    browser.goto_movies!
    browser.check_login
  else
    browser.incorrect_login
  end
end

# movie steps
Given(/^user navigates to movie form$/) do
  browser.goto_movie_form!
end

When(/^user fills all fields in movie form with movie title "([^"]*)"$/) do |movie_title|
  @movie_title = movie_title + rand(1...100).to_s
  browser.fill_movie_form(@movie_title)
  browser.goto_movies!
end

Then(/^the movie is created with success$/) do
  browser.check_movie_creation(@movie_title)
end

Given(/^the user is logged in$/) do
  step('the user navigates to QS demo homepage')
  step('a login is performed in QS demo')
  step('Login is "successful"')
end

And(/^user navigates to movie form editing movie "([^"]*)"$/) do |movie_title|
  if @movie_existence.eql? false or @movie_existence.nil?
    step('user navigates to movie form')
    step('user fills all fields in movie form with movie title "QS Movie Test"')
    step('the movie is created with success')
  end
  @movie_to_edit = movie_title
  browser.goto_movie_edit_form! @movie_to_edit
end

When(/^user edits description of the movie for "([^"]*)"$/) do |description|
  @description = description
  browser.edit_movie(@movie_to_edit, @description)
  browser.goto_movies!
end

Then(/^the movie was edited with success$/) do
  browser.check_movie_edition(@description)
end

And(/^user checks if movie "([^"]*)" exists$/) do |movie|
  @movie = movie
  @movie_existence = browser.check_movie_existence movie
end

# people steps
And(/^user navigates to people tab$/) do
  browser.goto_people!
end

And(/^user navigates to people form$/) do
  browser.goto_people_form!
end

When(/^user fills all fields in person form with person name "([^"]*)"$/) do |person_name|
  @person_name = person_name + [*('A'..'Z')].sample(3).join
  browser.fill_person_form @person_name
  browser.goto_people!
end

Then(/^the person is created with success$/) do
  browser.check_created_person @person_name
end

And(/^user checks if person "([^"]*)" exists$/) do |person_name|
  @person_name = person_name
  @person_existence = browser.check_person_existence person_name
end

And(/^user navigates to person form editing person "([^"]*)"$/) do |person_name|
  if @person_existence.eql? false or @person_existence.nil?
    step('user navigates to people form')
    step('user fills all fields in movie form with person name "QS User"')
    step('the person is created with success')
  end
  @person_to_edit = person_name
  browser.goto_person_edit_form! @person_to_edit
end

When(/^user edits surname of the person for "([^"]*)"$/) do |surname|
  @surname = surname + [*('A'..'Z')].sample(3).join
  browser.edit_person(@person_name, @surname)
  browser.goto_people!
end

Then(/^the person was edited with success$/) do
  browser.check_created_person @surname
end

And(/^user search for the movie title "([^"]*)"$/) do |movie_name|
  @movie_name = movie_name
  browser.search_movie(movie_name)
end

Then(/^the search is completed with success$/) do
  browser.check_search_success(@movie_name)
end