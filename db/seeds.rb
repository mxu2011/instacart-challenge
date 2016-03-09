# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require "faker"

def add_applicants(hash, dates)
  hash.each do |key, value|
    value.times do
      applicant = Applicant.new
      applicant.first_name = Faker::Name.name
      applicant.last_name = Faker::Name.name
      applicant.email = "#{SecureRandom.uuid}@gmail.com"
      applicant.phone = Faker::PhoneNumber.cell_phone
      applicant.phone_type = Applicant::PHONE_TYPES.sample
      applicant.region = Applicant::REGIONS.sample
      applicant.workflow_state = key.to_s
      applicant.save!
      applicant.update! created_at: dates.sample.to_datetime
    end
  end
end

week = (1..7).to_a.map { |i| "2014-12-#{i}" }
week2 = (8..14).to_a.map { |i| "2014-12-#{i}" }
week3 = (15..21).to_a.map { |i| "2014-12-#{i}" }
week4 = (22..28).to_a.map { |i| "2014-12-#{i}" }

add_applicants({
  applied: 10,
  quiz_started: 3,
  quiz_completed: 4,
  onboarding_requested: 1,
  onboarding_completed: 1,
  hired: 1
}, week)

add_applicants({
  applied: 20,
  quiz_started: 7,
  quiz_completed: 6,
  onboarding_requested: 3,
  onboarding_completed: 2,
  hired: 2
}, week2)

add_applicants({
  applied: 70,
  quiz_started: 20,
  quiz_completed: 10,
  onboarding_requested: 0,
  onboarding_completed: 0,
  hired: 0
}, week3)

add_applicants({
  applied: 40,
  quiz_started: 20,
  quiz_completed: 15,
  onboarding_requested: 5,
  onboarding_completed: 1,
  hired: 1
}, week4)
