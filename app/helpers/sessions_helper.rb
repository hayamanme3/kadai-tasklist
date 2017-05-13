module SessionsHelper
  def current_user
    @current_user ||= Task.find_by(id: session[:task_id])
  end

  def logged_in?
    !!current_user
  end
end