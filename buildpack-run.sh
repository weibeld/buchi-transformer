echo "Content of \$ENV_DIR:"
echo "$ENV_DIR"
echo "ls \$ENV_DIR:"
ls $ENV_DIR
if [[ -f "$ENV_DIR/BUILDPACK_RUN" ]]; then
  cat "$ENV_DIR/BUILDPACK_RUN"
fi
