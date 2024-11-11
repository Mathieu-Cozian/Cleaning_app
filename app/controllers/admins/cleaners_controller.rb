# app/controllers/admins/cleaners_controller.rb

module Admins
  class CleanersController < ApplicationController
    def index
      @statuses = Cleaner.statuses.keys
      @cleaners = filtered_cleaners
      @count_by_status = Cleaner.group(:status).count

      respond_to do |format|
        format.html # Renders admins/cleaners/index.html.erb by default
        format.turbo_stream do
          render partial: "admins/cleaners/cleaners_table", formats: :html, locals: { cleaners: @cleaners }
        end
      end
    end

    private

    def filtered_cleaners
      cleaners = Cleaner.includes(:user)
      cleaners = apply_status_filter(cleaners)
      cleaners = apply_search_filter(cleaners)
      apply_sort(cleaners)
    end

    def apply_status_filter(cleaners)
      return cleaners unless params[:status].present?

      cleaners.where(status: params[:status])
    end

    def apply_search_filter(cleaners)
      return cleaners unless params[:search].present?

      cleaners.joins(:user)
              .where("users.first_name ILIKE ? OR users.last_name ILIKE ?", "#{params[:search]}%", "#{params[:search]}%")
    end

    def apply_sort(cleaners)
      return cleaners unless params[:sort].present? && params[:direction].present?

      sortable_columns = %w[first_name last_name email]
      if sortable_columns.include?(params[:sort])
        cleaners.joins(:user).order("users.#{params[:sort]} #{params[:direction]}")
      else
        cleaners
      end
    end

    # END OF FILE
  end
end