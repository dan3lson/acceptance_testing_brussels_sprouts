require "spec_helper"

feature "User checks a recipe's deliciousness", %(
  As a user
  I want to submit a recipe name to see if it is delicious
  So that I know with confidence what to cook.

  Acceptance Criteria:
  [X] When I visit the root path, I can see a form to submit a recipe name
  [X] If I submit a recipe name with "brussels sprouts" in the name, I am
      sent to a "results" page telling me that the recipe is delicious
  [ ] If I submit a recipe name without "brussels sprouts" in the name, I am
      sent to a "results" page telling me that the recipe is not delicious
  [ ] From the "results" page, I am able to click a link bringing me back to
      the home page
  [ ] If I submit a blank entry to the form, I am brought to an error page
  [ ] From the error page, I can click a link bringing me back to the home page

) do

  scenario "user submits a recipe name containing 'brussels sprouts'" do
    visit "/"

    expect(page).to have_selector("form")
  end

  scenario "user submits a recipe name without 'brussels sprouts'" do
    visit "/"
    fill_in "Recipe Name", with: "brussels sprouts"
    click_on "Submit"

    expect(page).to have_content("\"brussels sprouts\" is a delicious recipe")
  end

  scenario "user navigates back to the home page after checking a recipe name" do
    visit "/"
    fill_in "Recipe Name", with: "brussels sprouts"
    click_on "Submit"
    click_on "Try again!"

    expect(page).to have_content("Instructions")
  end

  scenario "user submits an empty form" do
    visit "/"
    fill_in "Recipe Name", with: ""
    click_on "Submit"

    expect(page).to have_content("Error!")
    expect(page).to have_content("You can\'t submit an empty recipe name!")
  end

  scenario "user navigates back to the home page after submitting an empty form" do
    visit "/"
    fill_in "Recipe Name", with: ""
    click_on "Submit"
    click_on "Try again!"

    expect(page).to have_content("Instructions")
  end
end
