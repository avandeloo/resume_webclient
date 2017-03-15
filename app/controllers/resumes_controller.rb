class ResumesController < ApplicationController
  def index
    @students = Student.all
  end

  def show
    @student = Student.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do 
        pdf = Prawn::Document.new(:page_size => "LETTER", :page_layout => :portrait)
        pdf.font("Helvetica")
        
        pdf.text("#{@student.fullname}", {size: 25, align: :center, style: :bold})

        pdf.formatted_text([{text: "Full Stack "}, { text: "Web Developer", styles: [:bold]}], size: 14,  align: :center)

        pdf.bounding_box([0,650], width: 350) do 
          #PROFILE
          pdf.fill_color("97CAD8")
          pdf.text("PROFILE", {size: 9, style: :bold})
          pdf.fill_color("000000")
          pdf.move_down(-4)
          pdf.text("___________________________________________________", {align: :center})
          pdf.move_down(12)
          pdf.text("#{@student.bio}", {size: 9})

          #PROJECTS
          if @student.projects.length > 0
            pdf.move_down(10)
            pdf.fill_color("97CAD8")
            pdf.text("PROJECTS", {size: 9, style: :bold})
            pdf.fill_color("000000")
            pdf.move_down(-4)
            pdf.text("___________________________________________________", {align: :center})
            pdf.move_down(12)
            @student.projects.each do |project|
              pdf.text("#{project["name"]}", {size: 9, style: :bold})
              pdf.move_down(5)
              pdf.text("#{project["description"]}", {size: 9})
              pdf.move_down(5)
            end
          end

          #EXPERIENCE
          if @student.experiences.length > 0
            pdf.move_down(10)
            pdf.fill_color("97CAD8")
            pdf.text("EXPERIENCE", {size: 9, style: :bold})
            pdf.fill_color("000000")
            pdf.move_down(-4)
            pdf.text("___________________________________________________", {align: :center})
            pdf.move_down(12)
            @student.experiences.each do |experience|
              pdf.text("#{experience["job_title"]}", {size: 9, style: :bold})
              pdf.move_down(5)
              pdf.fill_color("AEAEAE")
              pdf.text("#{experience["company_name"]} | #{experience["address"]} | #{experience["start_date"].to_date.strftime("%Y")} -  #{experience["end_date"].to_date.strftime("%Y")}", {size: 9, style: :bold})
              pdf.fill_color("000000")
              pdf.move_down(5)
              pdf.indent(5) do
                pdf.text("• #{experience["details"]}", {size: 9})
              end
              pdf.move_down(5)
            end
          end
        end

        pdf.bounding_box([370,650], width: 180) do 
          
          #SKILLS
          if @student.skills.length > 0
            pdf.fill_color("97CAD8")
            pdf.text("SKILLS", {size: 9, style: :bold})
            pdf.fill_color("000000")
            pdf.move_down(-4)
            pdf.text("__________________________", {align: :center})
            pdf.move_down(12)
            @student.skills.each do |skill|
              pdf.text("#{skill["name"]}", {size: 9})
              pdf.move_down(5)
            end
          end

          #EDUCATION 
          if @student.educations.length > 0 
            pdf.move_down(10)
            pdf.fill_color("97CAD8")
            pdf.text("EDUCATION", {size: 9, style: :bold})
            pdf.fill_color("000000")
            pdf.move_down(-4)
            pdf.text("__________________________", {align: :center})
            pdf.move_down(12)
            @student.educations.each do |education|
              pdf.text("#{education["university_name"]}", {size: 9, style: :bold})
              pdf.move_down(5)
              pdf.text("#{education["degree"]} - #{education["details"]} |  #{education["start_date"].to_date.strftime("%Y")} -  #{education["end_date"].to_date.strftime("%Y")}", {size: 9})
              pdf.move_down(5)
            end
          end

          #COMMUNITY 
          if @student.communities.length > 0 
            pdf.move_down(10)
            pdf.fill_color("97CAD8")
            pdf.text("COMMUNITY", {size: 9, style: :bold})
            pdf.fill_color("000000")
            pdf.move_down(-4)
            pdf.text("__________________________", {align: :center})
            pdf.move_down(12)
            # @student.communities.each do |community|
            #   pdf.text("#{community["name"]}", {size: 9, style: :bold})
            #   pdf.move_down(5)
            #   pdf.text("#{community["degree"]} - #{community["details"]} |  #{community["start_date"].to_date.strftime("%Y")} -  #{community["end_date"].to_date.strftime("%Y")}", {size: 9})
            #   pdf.move_down(5)
            # end
          end

          #CONTACT 
          pdf.move_down(10)
          pdf.fill_color("97CAD8")
          pdf.text("CONTACT", {size: 9, style: :bold})
          pdf.fill_color("000000")
          pdf.move_down(-4)
          pdf.text("__________________________", {align: :center})
          pdf.move_down(12)
          # pdf.move_down(5)
          pdf.text("#{@student.address}", {size: 9})
          pdf.move_down(5)
          pdf.text("#{@student.address}", {size: 9})
          pdf.move_down(5)
          pdf.formatted_text([{text: "github", styles: [:bold]}, {text: "#{@student.github_url[6..@student.github_url.length]}"}], size: 9)
          pdf.move_down(5)
          pdf.formatted_text([{text: "linkedin", styles: [:bold]}, {text: "#{@student.linkedIn_url[8..@student.linkedIn_url.length]}"}], size: 9)
          pdf.move_down(5)
          pdf.formatted_text([{text: "medium", styles: [:bold]}, {text: "#{@student.personal_blog[3..@student.personal_blog.length]}"}], size: 9)
          

        end 

        send_data pdf.render

      end
    end

  end
  
end
