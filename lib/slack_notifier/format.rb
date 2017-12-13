module SlackNotifier
  module Format
    module_function

    # header = 'any titles to be displayed'
    # body = {'title1': content1, 'title2': content2, ... }
    def compose_attachments(header={}, **body)
      {
        attachments:
          [
            construct_header(header).merge(
              "fields": construct_body(**body)
            ).compact
          ]
      }
    end

    def construct_header(header)
      {
        "color":        'good',
        "title":        header[:title],
        "text":         header[:text],
        "ts":           Time.zone.now.to_i,
      }
    end

    def construct_body(**fields)
      fields.map do |key, val|
        {title: key, value: val}
      end
    end
  end
end
