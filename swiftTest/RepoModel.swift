//
//  RepoModel.swift
//  swiftTest
//
//  Created by 朱校明 on 2021/3/18.
//  Copyright © 2021 朱校明. All rights reserved.
//


import HandyJSON
///
struct RepoModel: HandyJSON {
    
    var `private`: Int?
    
    var merges_url: String?
    
    var forks: Int?
    
    var notifications_url: String?
    
    var contributors_url: String?
    
    var issue_comment_url: String?
    
    var commits_url: String?
    
    var keys_url: String?
    
    var subscribers_count: Int?
    
    var has_projects: Int?
    
    var created_at: String?
    
    var stargazers_url: String?
    ///
    var owner: Owner?
    
    var url: String?
    
    var releases_url: String?
    
    var tags_url: String?
    
    var pulls_url: String?
    
    var branches_url: String?
    
    var svn_url: String?
    
    var forks_url: String?
    
    var disabled: Int?
    
    var labels_url: String?
    
    var milestones_url: String?
    
    var git_commits_url: String?
    
    var trees_url: String?
    
    var open_issues: Int?
    
    var html_url: String?
    
    var blobs_url: String?
    
    var default_branch: String?
    
    var fork: Int?
    
    var ssh_url: String?
    
    var archive_url: String?
    
    var language: String?
    
    var size: Int?
    
    var issue_events_url: String?
    
    var compare_url: String?
    
    var name: String?
    
    var homepage: String?
    
    var forks_count: Int?
    
    var subscribers_url: String?
    
    var id: Int?
    
    var git_refs_url: String?
    
    var watchers_count: Int?
    
    var node_id: String?
    ///
    var license: License?
    
    var issues_url: String?
    
    var pushed_at: String?
    
    var full_name: String?
    
    var archived: Int?
    ///
    var organization: Organization?
    
    var statuses_url: String?
    
    var mirror_url: String?
    
    var teams_url: String?
    
    var open_issues_count: Int?
    
    var git_url: String?
    
    var description: String?
    
    var assignees_url: String?
    
    var has_wiki: Int?
    
    var has_issues: Int?
    
    var has_pages: Int?
    
    var languages_url: String?
    
    var comments_url: String?
    
    var collaborators_url: String?
    
    var contents_url: String?
    
    var clone_url: String?
    
    var downloads_url: String?
    
    var stargazers_count: Int?
    
    var deployments_url: String?
    
    var git_tags_url: String?
    
    var hooks_url: String?
    
    var watchers: Int?
    
    var subscription_url: String?
    
    var network_count: Int?
    
    var temp_clone_token: String?
    
    var updated_at: String?
    
    var events_url: String?
    
    var has_downloads: Int?
}

///
struct  Organization: HandyJSON {
    
    var html_url: String?
    
    var gists_url: String?
    
    var login: String?
    
    var node_id: String?
    
    var subscriptions_url: String?
    
    var type: String?
    
    var avatar_url: String?
    
    var followers_url: String?
    
    var site_admin: Int?
    
    var starred_url: String?
    
    var repos_url: String?
    
    var received_events_url: String?
    
    var gravatar_id: String?
    
    var following_url: String?
    
    var organizations_url: String?
    
    var events_url: String?
    
    var url: String?
    
    var id: Int?
}

///
struct  License: HandyJSON {
    
    var name: String?
    
    var spdx_id: String?
    
    var key: String?
    
    var node_id: String?
    
    var url: String?
}

///
struct  Owner: HandyJSON {
    
    var subscriptions_url: String?
    
    var html_url: String?
    
    var site_admin: Int?
    
    var type: String?
    
    var gists_url: String?
    
    var organizations_url: String?
    
    var followers_url: String?
    
    var following_url: String?
    
    var events_url: String?
    
    var avatar_url: String?
    
    var gravatar_id: String?
    
    var login: String?
    
    var url: String?
    
    var id: Int?
    
    var repos_url: String?
    
    var node_id: String?
    
    var received_events_url: String?
    
    var starred_url: String?
}

