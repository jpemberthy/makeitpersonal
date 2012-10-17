module SongPresenter
  SIDENOTE_REGEX = /\[\[(.*?)\]\]/m

  def embed
    url = youtube_url
    return unless url.present?
    return unless url.match(/youtube.com\/watch\?v=/)
    id = url.gsub(/.+v=(.\w+)/, "\\1")
    "<iframe height='23' width='265' src='http://www.youtube.com/embed/#{id}?rel=0&autohide=0&fs=0&modestbranding=1&theme=light' frameborder='0' ></iframe>".html_safe
  end

  def name
    "#{artist.titleize} &mdash; #{title.titleize}".html_safe
  end

  def sidenotes
    lyrics.scan(SIDENOTE_REGEX).flatten.map(&:replace_newlines) || []
  end

  def body
    body = lyrics.gsub(/\*(.*?)\*/m, '<em>\1</em>') # emph
    body = body.gsub(SIDENOTE_REGEX, "")            # remove sidenotes
    body.replace_newlines
  end
end
