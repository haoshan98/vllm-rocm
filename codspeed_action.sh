# Configure and run codspeed-runner

# Get the runner arguments
RUNNER_ARGS=""
if [ -n "be5d5cd5-e053-4b63-8c53-8c95cc84e907" ]; then
  RUNNER_ARGS="$RUNNER_ARGS --token be5d5cd5-e053-4b63-8c53-8c95cc84e907"
fi
if [ -n "" ]; then
  RUNNER_ARGS="$RUNNER_ARGS --working-directory=./"
fi
if [ -n "" ]; then
  RUNNER_ARGS="$RUNNER_ARGS --upload-url="
fi

echo "set RUNNER_ARGS"

# Install the CodSpeedHQ/runner
head_status=$(curl -I -fsSL -w "%{http_code}" -o /dev/null https://github.com/CodSpeedHQ/runner/releases/download/v2.0.2/codspeed-runner-installer.sh)
if [ "$head_status" -eq 404 ]; then
  echo "Error: Version 2.0.2 is not available in https://github.com/CodSpeedHQ/runner/releases, please a correct version."
  exit 1
else
  curl -fsSL https://github.com/CodSpeedHQ/runner/releases/download/v2.0.2/codspeed-runner-installer.sh | bash -s -- --quiet
fi

echo "install CodSpeedHQ/runner"

# Run the benchmarks
codspeed-runner $RUNNER_ARGS -- 'pytest tests/kernels/test_layernorm.py --codspeed'
