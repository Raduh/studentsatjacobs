module ArticlesHelper
    def toImageSrc imageURL
        imageURL || "/assets/jacobs_logo.png"
    end
end
