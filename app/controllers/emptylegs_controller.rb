class EmptylegsController < InheritedResources::Base

  private

    def emptyleg_params
      params.require(:emptyleg).permit(:aircraft_type, :departon, :from, :to, :seats, :price, :min_price)
    end
end

