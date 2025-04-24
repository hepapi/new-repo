#### Rancher UI Helm ile Yükleme

[📄 Install Rancher UI ](https://ranchermanager.docs.rancher.com/getting-started/installation-and-upgrade/install-upgrade-on-a-kubernetes-cluster)

- Stable olanı seçiyoruz

```bash
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable

helm repo update
```

- Create a Namespace for Rancher

```bash
kubectl create namespace cattle-system
```

- Choose your SSL Configuration
- Bizim şu an kullanacağımız tabloda sonuncu olan `Certificates from Files`
- Bizde cert-manager gerekmiyor o adımları geçiyorum

- 5. Install Rancher with Helm and Your Chosen Certificate Option maddede `Certificates from Files`ı seçiyorum

- Now that Rancher is deployed, see `Adding TLS Secrets` to publish the certificate files so Rancher and the Ingress controller can use them. 
- `Adding TLS Secrets`a tıklıyorum. Bir secret oluşturacağım

[📄 Adding TLS Secrets ](https://ranchermanager.docs.rancher.com/getting-started/installation-and-upgrade/resources/add-tls-secrets)

- Böylece Rancher Ingress Controller, bu TLS sertifikasını kullanarak HTTPS bağlantıları sağlar.

```bash
kubectl -n cattle-system create secret tls tls-rancher-ingress \
  --cert=tls.crt \
  --key=tls.key
```

- Secret oluşturduktan sonra diğer sayfadan devam ediyoruz

```bash
helm install rancher rancher-<CHART_REPO>/rancher \
  --namespace cattle-system \
  --set hostname=test-rancher.axa.com.tr \
  --set bootstrapPassword=admin \
  --set ingress.tls.source=secret
```

```bash
helm install rancher rancher-stable/rancher \

Biz ilk satırı bu şekilde yazdık

hostame'i de değiştireceğiz
```

- Helm'i çalıştırdıktan sonra çıkan komutu al

```bash
cd
mkdir helm-info
cd helm-info
vi rancher.txt
```

- Bu dosyanın içine yapıştır
- Bu tür bir rancher.txt dosyasını oluşturma ve içine Helm komutunun çıktısını yapıştırma işlemi, kurulumun kaydını tutmak ve ileride referans almak için yapılır.

```bash
kubectl -n cattle-system get deploy rancher

NAME      DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
rancher   3         3         3            3           3m
```
- Rancher için bu şekilde bir deploy oluşacak. Kontrol edebilirsin

```bash
kubectl -n cattle-system get ing
```
- 3 master node'umuza giden bir ing olacak

- Artık browserden Rancher UI'a erişebiliriz. 
