LOBBY_DISTRIBUTION_VERSION:=""
RELAY_DISTRIBUTION_VERSION:=""

TERRAFORM_DIR:=deploy/terraform
HELM_DIR:=deploy/helm

UC = $(shell echo '$1' | tr '[:lower:]' '[:upper:]')

KUBE_CONFIG_PATH:=$(HOME)/.kube/config
export KUBE_CONFIG_PATH

.PHONY: build-%-image
build-%-image:
	docker build -t $*:${$(call UC,$*)_DISTRIBUTION_VERSION} --build-arg DISTRIBUTION_VERSION=${$(call UC,$*)_DISTRIBUTION_VERSION}  ./$*

.PHONY: load-%-image
load-%-image:
	kind load docker-image $*:${$(call UC,$*)_DISTRIBUTION_VERSION}

.PHONY: build-%-chart
build-%-chart:
	helm dependency build $(HELM_DIR)/$*

.PHONY: terraform-%
terraform-%:
	terraform -chdir=${TERRAFORM_DIR} $*

.PHONY: kind
kind:
	kind create cluster --config=deploy/kind/cluster.yaml

.PHONY: ingress
ingress:
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/kind/deploy.yaml

.PHONY: images
images: build-lobby-image build-relay-image load-lobby-image load-relay-image

.PHONY: charts
charts: build-lobby-chart build-relay-chart build-cwm-chart

.PHONY: local
local: TF_VAR_values = '["../values/local.yaml"]'
local: images charts terraform-apply
