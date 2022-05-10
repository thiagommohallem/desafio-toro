# Desafio Toro Mobile
Essa é uma abordagem do desafio https://github.com/ToroInvestimentos/desafio-toro-mobile

## Pré-requisitos

O App encontra-se na pasta [toro_app](https://github.com/thiagommohallem/desafio_toro_mobile/tree/master/toro_app) deste repositório, essa é só uma página introdutória

### Instalação Docker

O App utiliza de uma coexão WebSocket fornecida por um container docker que deve ser executado, **antes do app**, com o seguinte comando para funcionar:

  `docker run -p 8080:8080 toroinvest/quotesmock`

Caso não tenha o docker instalado, clique [aqui](https://docs.docker.com/get-docker/) para navegar até as instruções oficiais de como instalar

### Instalação Flutter

O App foi inteiramente feito em Flutter, e é essencial que esteja instalado no computador para execução.

Caso não tenha o Flutter instalado, clique [aqui](https://docs.flutter.dev/get-started/install) para navegar até as instruções oficiais de como instalar

### Instalação das dependências do Flutter

Navegue até a pasta raiz do app toro_app e execute o comando:

`flutter pub get`

## Instruções de como executar

Certifique-se que esta no diretório raiz do app desafio_toro_mobile/toro_app/ e execute:
`flutter run` , por padrão o comando já executa em modo Debug
Caso queira rodar o projeto em modo release, execute: `flutter run --release`

Obs: O Flutter precisa de um simulador ou dispositivo físico para rodar, o tutorial está incluso na [documentação oficial do Flutter](https://docs.flutter.dev)

Caso queira rodar em um dispositivo fixo com o Docker rodando em um computador da mesma rede, é necessário alterar o ip 127.0.0.1 para o ip do computador no arquivo [home.module.dart](https://github.com/thiagommohallem/desafio_toro_mobile/blob/master/toro_app/lib/app/modules/home/module/home.module.dart) (linha 15)

## Instruções de como rodar os testes
Certifique-se que esta no diretório raiz do app desafio_toro_mobile/toro_app/ e execute:
`flutter test`
