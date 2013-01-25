module ButtonsHelper

  def player(button)

      html = ''
      html << "<div id='jquery_jplayer_1'></div>"
      html << "		<div class='jp-audio' button-id='#{button.id}'user-id='#{session[:user_id]}'>"
      html << "    			<div class='jp-type-single'>"
      html << "    				<div class='jp-gui jp-interface'>"
      html << "    					<ul id='button-#{button.id}' class='jp-controls'>"
      html << "    						<li><a href='#{button.media.url}' button-id='#{button.id}' class='jp-button jp-play-new' tabindex='1' >play</a></li>"
      html << "    					</ul>"
      html << "    				</div>"
      html << "    				<div id='title_#{button.id}' class='jp-title'>"
      html << "    					<ul>"
      html << "    						<li>#{button.title} <br/> #{t('player.plays')}: <span id='total_plays_#{button.id}'>#{(!button.count.nil? ? button.count.value : 0)}</span></li>"
      html << "    					</ul>"
      html << "    				</div>"

      link_label = t("player.add_favorites")
      favorite_state = 0
      if button.is_favorite(session[:user_id])
        link_label = t("player.remove_favorites")
        favorite_state = 1
      end
      html << "    				<div class='jp-function' id='function_#{button.id}' button-id='#{button.id}'>"
      html << "    				  <a href='#' favorite-state='#{favorite_state}' button-id='#{button.id}' id='favorite_link_#{button.id}' class='jp-function jp-function-favorite'>#{link_label}</a><hr />" if session[:user_id]
      html << "    				  <a href='/view/?b=#{button.share_code}' button-id='#{button.id}' id='favorite_link_#{button.id}' class='jp-function'>#{t('player.share')}</a>"
      html << "    				</div>"

      html << "    			</div>"
      html << "   </div>"

      html.html_safe

  end
end
