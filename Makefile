IMAGES_DIR=
VRS = vr-xcon vr-bgp topology-machine csr c8000v c8000v-sd-wan nxos nxos9kv routeros sros ucpe-oneos veos vmx vsr1000 vqfx vrp xrv xrv9k vedge vmanage vsmart
VRS_PUSH = $(VRS:=-push)
VRS_TEST = $(VRS:=-test)

.PHONY: all $(VRS) $(VRS_PUSH) $(VRS_TEST)

all: $(VRS)

$(VRS):
ifneq ($(IMAGES_DIR),)
	cp -av $(IMAGES_DIR)/$@/* $@/
endif
	cd $@; $(MAKE)

docker-push: $(VRS_PUSH)

$(VRS_PUSH):
	cd $(@:-push=); $(MAKE) docker-push

$(VRS_TEST):
	cd $(@:-test=); $(MAKE) docker-test
