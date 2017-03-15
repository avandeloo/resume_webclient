class Student
  attr_accessor :id, :first_name, :last_name, :email, :address, :phone_number, :bio, :linkedIn_url, :twitter_handle, :personal_blog, :resume_url, :github_url, :educations, :experiences, :skills, :projects

  def initialize(hash={})
    @id = hash["id"]
    @first_name = hash["first_name"]
    @last_name = hash["last_name"]
    @email = hash["email"]
    @address = hash["address"]
    @phone_number = hash["phone_number"]
    @bio = hash["bio"]
    @linkedIn_url = hash["linkedin_url"]
    @twitter_handle = hash["twitter_handle"]
    @personal_blog = hash["personal_url"]
    @resume_url = hash["resume_url"]
    @github_url = hash["github_url"]
    @educations = hash["educations"]
    @experiences = hash["experiences"]
    @skills = hash["skills"]
    @projects = hash["capstones"]

  
  end

  def fancy_fullname
    "#{last_name}, #{first_name}"
  end

  def fullname
    "#{first_name} #{last_name}"
  end

  def self.find(student_id)
    Student.new(Unirest.get("#{ ENV['API_HOST_URL'] }/students/#{student_id}.json").body)
  end

  def self.all
    student_collection = []
    api_students = Unirest.get("#{ ENV['API_HOST_URL'] }/students.json").body

    api_students.each do |student_hash|
      student_collection << Student.new(student_hash)
    end

    student_collection
    
  end
end