module SongPresenter
  SIDENOTE_REGEX = /\[\[(.*?)\]\]/m

  def embed
    url = youtube_url
    return unless url.present?
    return unless url.match(/youtube.com\/watch\?v=/)
    id = url.gsub(/.+v=(.\w+)/, "\\1")
    "<iframe  style='border: 10px solid #222' height='230' width='230' src='http://www.youtube.com/embed/#{id}?rel=0&autohide=1&fs=0&modestbranding=1&theme=light' frameborder='0' ></iframe>".html_safe
  end

  def name
    "#{artist.titleize} &mdash; #{title.titleize}".html_safe
  end

  def sidenotes
    lyrics.scan(SIDENOTE_REGEX).flatten.map(&:replace_newlines) || []
  end

  # TODO: I got 99 problems... and these 3 regexes are in that list.
  def body
    body = lyrics.gsub(/\*(.*?)\*/m, '<em>\1</em>') # emph
    i = 1
    while body.match(SIDENOTE_REGEX) # colorize the sidenotes
      body.sub!(SIDENOTE_REGEX, "<span class='sidenote'>[#{i}]</span>")
      i += 1
    end
    body.gsub!(/\n<span class='sidenote'>\[\d+\]<\/span>(\r\n|$)/m, "") # remove the notes on empty lines
    body.replace_newlines
  end
end
