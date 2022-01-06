class NftsController < ApplicationController
    def index  
        @nfts = Nft.all  
        render json: @nfts
    end 
end
