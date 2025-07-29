# ==============================
# CONFIG
# ==============================

TEAM_A_DIR=subrepo
TEAM_B_DIR=subrepo-number-2

TEAM_A_REPO=https://github.com/anafsouza/subrepo.git
TEAM_B_REPO=https://github.com/anafsouza/subrepo-number-2.git

# ==============================
# INIT / UPDATE / PULL
# ==============================

init-submodules:
	git submodule init
	git submodule update

update-submodules:
	git submodule update --remote --merge

pull-submodules: update-submodules
	@echo "Pulled latest commits from all submodules."

# ==============================
# ADD
# ==============================

add-submodules:
	@git submodule add $(TEAM_A_REPO) $(TEAM_A_DIR) || echo "Submodule 'subrepo' already exists"
	@git submodule add $(TEAM_B_REPO) $(TEAM_B_DIR) || echo "Submodule 'subrepo-number-2' already exists"
	@git submodule update --init --recursive

# ==============================
# COMMIT / PUSH
# ==============================

commit-submodules:
	git add .
	if git diff --cached --quiet; then \
		echo "No changes to commit."; \
	else \
		git commit -m "chore: update submodules"; \
		git push origin main; \
	fi

# ==============================
# FULL SYNC (optional)
# ==============================

sync-submodules: pull-submodules commit-submodules
