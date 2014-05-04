module ArticlesHelper
    def toImageSrc imageURL
        imageURL || "/assets/jacobs_logo.png"
        return "/assets/jacobs_logo.png" if imageURL.blank?
        imageURL
    end
end
