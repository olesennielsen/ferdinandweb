# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# 
# 
# 

companies = Company.create([{name: 'olesen & nielsen'}])

designers = Designer.create([{email: 'emil@emil.com', password: 'qwerty', password_confirmation: 'qwerty', first_name: 'Emil', last_name: 'Nielsen', company_id: 1, role: 1}])

campaigns = Campaign.create([{name: 'Bananas', company_id: 1}])

pages = Page.create([{number: 1, campaign_id: 1}, {number: 2, campaign_id: 1}, {number: 3, campaign_id: 1}, {number: 4, campaign_id: 1}, {number: 5, campaign_id: 1}])

pageobjects = Pageobject.create([{page_id: 1, object_type: 0, textobject: "HEJ HEJ BANANAS", color: 4}, 
                                  {page_id: 2, object_type: 1, link: "http://manbir-online.com/grafics/banana.jpg"},
                                  {page_id: 3, object_type: 1, link: "http://manbir-online.com/grafics/banana.jpg"}, 
                                  {page_id: 4, object_type: 2, link: "http://www.youtube.com/embed/OTVE5iPMKLg"}])