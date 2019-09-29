module ContentParsable
  def parse_title(raw_title)
    return "" unless raw_title

    regex = %r{:\s(?<title>.+)\s*:}
    matches = raw_title.match(regex)
    return "" unless matches

    matches[:title]
  end

  def parse_category(raw_category)
    return "" unless raw_category

    regex = %r{(?<category>\w+(.\w+)*)}
    matches = raw_category.match(regex)
    return "" unless matches

    matches[:category]
  end


  def parse_rank(raw_rank)
    return "" unless raw_rank

    regex = %r{(?<rank>#.+?)(?=\s\()}
    matches = raw_rank.match(regex)
    return "" unless matches

    matches[:rank]
  end

  def parse_dimensions(raw_dimensions)
    return "" unless raw_dimensions

    regex = %r{(?<dimensions>\w.+$)}

    matches = raw_dimensions.match(regex)
    return "" unless matches

    matches[:dimensions]
  end
end
