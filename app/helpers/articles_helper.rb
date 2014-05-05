module ArticlesHelper
    def toImageSrc imageURL
        return "/assets/jacobs_logo.png" if imageURL.blank?
        imageURL
    end
end
