set -e

GITHUB_REPO=$1
DOCKER_HUB_REPO=$2
REPO_NAME=$(basename $GITHUB_REPO)

echo "Cloning GitHub repo..."
git clone https://github.com/$GITHUB_REPO

cd $REPO_NAME

echo "Building Docker image..."
docker build -t $DOCKER_HUB_REPO .

echo "Logging in to Docker Hub..."
echo "$DOCKER_PWD" | docker login -u "$DOCKER_USER" --password-stdin

echo "Pushing image to Docker Hub..."
docker push $DOCKER_HUB_REPO

cd ..
echo "Cleaning up..."
rm -rf $REPO_NAME

echo "Voila! Image is now on Docker Hub."
