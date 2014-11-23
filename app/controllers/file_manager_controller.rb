class FileManagerController < ApplicationController
  skip_before_action :verify_authenticity_token, only: ['elfinder']

  authorize_resource class: false

  layout false

  def index
    render :index
  end

  def browser
    render :browser
  end

  def elfinder
    h, r = ElFinder::Connector.new(
      root: File.join(Rails.public_path, 'uploads', 'files'),
      url: '/uploads/files',
      perms: {
        'forbidden' => { read: false, write: false, rm: false },
        # /README/ => { write: false },
        # /pjkh\.png$/ => { write: false, rm: false },
      },
      extractors: {
        'application/zip' => ['unzip', '-qq', '-o'],
        'application/x-gzip' => ['tar', '-xzf'],
      },
      archivers: {
        'application/zip' => ['.zip', 'zip', '-qr9'],
        'application/x-gzip' => ['.tgz', 'tar', '-czf'],
      },
      thumbs: true
    ).run(params)

    headers.merge!(h)
    render (r.empty? ? { nothing: true } : { text: r.to_json })
  end

  protected
  def skip_std_filters
    true
  end
end
