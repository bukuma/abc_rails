class TopicsController < ApplicationController
    def new
        render :new
    end
    
    def create
        redirect_to 'topics/new'
    end
    
    def edit
        render :edit
    end
    
    def update
        redirect_to 'topics/edit'
    end
end
