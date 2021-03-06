require 'net/http'
require 'uri'

class AlgorithmsController < ApplicationController
  # GET /algorithms
  # GET /algorithms.xml
  def index
    @algorithms = Algorithm.ordered_by_name

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @algorithms }
    end
  end

  # GET /algorithms/1
  # GET /algorithms/1.xml
  def show
    @algorithm = Algorithm.first_by_name(params[:id])
    if @algorithm.nil?
      flash[:notice] = "Unknown algorithm '#{name}', perhaps suggest it!"
      redirect_to(algorithms_path) 
      return
    end
    
    if !@algorithm.code_file.blank? and @algorithm.code_file != "N/A"
      @filename = get_filename(@algorithm.code_file)
      @filedata = download(@algorithm.code_file)
      if !@filedata.nil?
        @filedata = @filedata.strip
        split = @filedata.split("\n")
        @filedata = split[6...split.length].join("\n")
      end
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @algorithm }
    end
  end
  
  private 
  
  def get_filename(source_address)
    return source_address.split('/').last
  end
  
  def download(source_address)
    url = URI.parse(source_address)
    http = Net::HTTP.new(url.host, url.port)
    resp, data = http.request_get(url.path, {})
    return nil if resp.code.to_i < 200 or resp.code.to_i > 299
    return data
  end

end
