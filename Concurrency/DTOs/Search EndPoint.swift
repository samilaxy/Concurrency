//
//  Search EndPoint.swift
//  Concurrency
//
//  Created by Noye Samuel on 03/04/2023.
//

import Foundation

    // MARK: - Welcome
struct UnsplashPhoto: Decodable {
    let total, totalPages: Int
    let results: [ApiResult]
}

    // MARK: - Result
struct ApiResult: Decodable {
    let id: String
    let createdAt, updatedAt, promotedAt: Date
    let width, height: Int
    let color, blurHash, description, altDescription: String
    let urls: Urls
    let links: ResultLinks
    let likes: Int
    let likedByUser: Bool
    let currentUserCollections: [String]
    let sponsorship: String
    let topicSubmissions: TopicSubmissions
    let user: User
    let tags: [ImageTag]
}

    // MARK: - ResultLinks
struct ResultLinks: Decodable {
    let linksSelf, html, download, downloadLocation: String
}

    // MARK: - Tag
struct ImageTag: Decodable {
    let type, title: String
    let source: Source?
}

    // MARK: - Source
struct Source: Decodable {
    let ancestry: Ancestry
    let title, subtitle, description, metaTitle: String
    let metaDescription: String
    let coverPhoto: CoverPhoto
}

    // MARK: - Ancestry
struct Ancestry: Decodable {
    let type, category: Category
    let subcategory: Category?
}

    // MARK: - Category
struct Category: Decodable {
    let slug, prettySlug: String
}

    // MARK: - CoverPhoto
struct CoverPhoto: Decodable {
    let id: String
    let createdAt, updatedAt, promotedAt: Date
    let width, height: Int
    let color, blurHash, description, altDescription: String
    let urls: Urls
    let links: ResultLinks
    let likes: Int
    let likedByUser: Bool
    let currentUserCollections: [String]
    let sponsorship: String
    let topicSubmissions: TopicSubmissions
    let premium: Bool
    let user: User
}

    // MARK: - TopicSubmissions
struct TopicSubmissions: Decodable {
    let animals: Animals?
}

    // MARK: - Animals
struct Animals: Decodable {
    let status: String
    let approvedOn: Date
}

    // MARK: - Urls
struct Urls: Decodable {
    let raw, full, regular, small: String
    let thumb, smallS3: String
}

    // MARK: - User
struct User: Decodable {
    let id: String
    let updatedAt: Date
    let username, name, firstName, lastName: String
    let twitterUsername, portfolioURL, bio, location: String
    let links: UserLinks
    let profileImage: ProfileImage
    let instagramUsername: String
    let totalCollections, totalLikes, totalPhotos: Int
    let acceptedTos, forHire: Bool
    let social: Social
}

    // MARK: - UserLinks
struct UserLinks: Decodable {
    let linksSelf, html, photos, likes: String
    let portfolio, following, followers: String
}

    // MARK: - ProfileImage
struct ProfileImage: Decodable {
    let small, medium, large: String
}

    // MARK: - Social
struct Social: Decodable {
    let instagramUsername, portfolioURL, twitterUsername, paypalEmail: String
}
