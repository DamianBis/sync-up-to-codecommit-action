# Sync up to AWS CodeCommit Action

Synchronize from GitHub repository to AWS CodeCommit via GitHub Actions.  
No need to ssh-private-key. Need to AWS IAM Credentials only.

## Example usage

```yaml
name: sync up to codecommit

on:
  push:
    tags-ignore:
      - '*'
    branches:
      - '*'

jobs:
  sync:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v3
        with:
          fetch-depth: 0

      - name: Sync up to CodeCommit
        uses: DamianBis/sync-up-to-codecommit-action@v1
        with:
          repository_name: test_repo
          aws_region: us-east-1
          aws-access-key-id: ${{ secrets.TEST_AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.TEST_AWS_SECRET_ACCESS_KEY }}
```

## Inputs

- `repository_name` **Required** CodeCommit repository name.
- `aws_region` **Required** Region of the CodeCommit repository.

## License

[MIT](LICENSE)

