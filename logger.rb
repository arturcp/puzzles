class Logger
  def initialize(log_mode)
    @log_mode = log_mode
  end

  def loggin?
    @log_mode
  end

  def log(message, type = 'puts')
    return unless @log_mode

    if type == 'puts'
      puts message
    elsif type == 'print'
      print message
    end
  end
end
