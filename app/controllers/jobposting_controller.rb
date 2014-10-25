class JobpostingController < ApplicationController
  before_action :set_jobposting, only: [:show, :edit, :update, :destroy]

  skip_before_filter :verify_authenticity_token
  protect_from_forgery :except => :add

  def add
    company_id = params[:company_id]
    title      = params[:title]
    job_type   = params[:job_type]
    info       = params[:info]
    ret        = Jobposting.add(company_id, title, job_type, info)
    render json: ret
  end

  def show_all
    ret = Jobposting.show_all()
    render json: ret
  end

  def show_by_posting_id
    posting_id = params[:id]
    puts posting_id
    ret = Jobposting.show_by_posting_id(posting_id)
    render json: ret
  end

  def show_by_company_id
    company_id = params[:id]
    ret = Jobposting.show_by_company_id(company_id)
    render json: ret
  end

  def search
    query = params[:q]
    ret = Jobposting.search(query)
    render json: ret
  end

  def delete
    company_id = params[:company_id]
    posting_id = params[:posting_id]
    ret = Jobposting.remove(posting_id, company_id)
    render json: ret
  end

end