module ApplicationHelper
  def is_menu_selected(param, modulo)
    result = ((param == modulo )||(modulo==session[:menu])? "class='active'" : "")
    result
  end

  def locale_builder(request_path, locale)
    full_path = request_path.to_s.gsub(/[\?|\&]locale=[[:alpha:]]+/, "")
    path_simbol = full_path.include?("?") ? "&" : "?"
    full_path + path_simbol + "locale=" + locale
  end
end
