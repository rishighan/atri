#model for reporting and analytics
class Exit
    extend Legato::Model

    metrics :exits, :pageviews
    dimensions :browser


end
