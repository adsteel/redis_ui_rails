# Contribution Guidelines

Want to get started working on redis_ui_rails? Start here!

## How To Contribute

* Consider creating an issue first, to solicit opinions and buy-in
* Follow the local development steps described in [the README](README.md#local-development)
* Create a topic branch: `git checkout -b my_feature`
* Commit your changes
* Add a [changelog entry](CHANGELOG.md)
* Keep up to date: `git fetch && git rebase origin/master`

Once you’re ready:

* Fork the project on GitHub
* Add your repository as a remote: `git remote add your_remote your_repo`
* Push up your branch: `git push your_remote awesome_feature`
* Create a Pull Request for the topic branch, asking for review.

If you’re looking for things to hack on, please check
[GitHub Issues](https://github.com/rubygems/rubygems.org/issues). If you’ve
found bugs or have feature ideas don’t be afraid to pipe up and ask the
[mailing list](https://groups.google.com/group/rubygems-org) or IRC channel
(`#rubygems` on `irc.freenode.net`) about them.

## Acceptance

**Contributions WILL NOT be accepted without tests.**

If you haven't tested before, start reading up in the `spec/` directory to see
what's going on. This gem roughly rollows the [testing pyramid](https://martinfowler.com/articles/practical-test-pyramid.html) philosophy.

## Branching

For your own development, use the topic branches. Basically, cut each
feature into its own branch and send pull requests based off those.

The `main`` branch is the primary production branch. **Always** should be fast-forwardable.

