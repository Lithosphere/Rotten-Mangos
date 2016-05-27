module MoviesHelper

  def formatted_date(date)
    date.strftime("%b %d, %Y")
  end
  
  # def which_time_frame(choice=nil)
  #   case choice
  #     when a
  #      < 90
  #     when b
  #      90..120
  #     when c
  #      > 120
  #   end
  # end

end