class Template

  def initialize(page, data = {})
    @data = data
    @page = page

    file = File.join(File.dirname(__FILE__), "/templates/#{page}.html.erb")

    @template = File.read(file)
  end

  def visit_count
    @data[:visit_count]
  end

  def survey_saved
    @data[:survey_saved]
  end


  def survey_data
    @data[:survey_data]
  end

  def message
    @data[:message]
  end

  def success
    @data[:success]
  end



  

  def render
    ERB.new(@template).result(binding)
  end
end