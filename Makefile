.PHONY: check setup open build sim clean

check:
	./scripts/check_install.sh

setup:
	AMS_DEMO_HOME=$(CURDIR) ./scripts/setup_xschem_paths.sh

open:
	./scripts/open_xschem.sh

build:
	./scripts/build_counter_icarus.sh

sim: build
	./scripts/run_ngspice_batch.sh

clean:
	./scripts/clean.sh
