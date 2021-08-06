
# Desafio programação - para vaga desenvolvedor Mobile

By **Saulo Senoski.**

# Descrição do projeto

 - [x]  Tela de login usando (email e senha);
 - [x] Tela home com mapa renderizando um ponto na localização atual do device;
 - [x] Realizar o login utilizando Firebase Auth;
 - [x] Armazenar os dados do usuário na store global;
 - [x] Rastrear login com sucesso e renderização com sucesso com Analytics (enviar um evento com dados considerados primordiais nesses dois casos);
 - [x] Rastrear os erros e envia-los ao Crashlytics;
 - [x] Armazenar na base de dados local  o usuário logado e sua última posição no mapa; 

>  (WatermelonDB não disponível para Flutter, foi então utilizado Hive,
> DB que apresenta ótima performance e segurança);

 - [x] Testar fluxo de login (unit e e2e);
 - [x] Testar fluxo da home (unit e e2e).

# Usage

 1. clone este repositório usando
> `git clone https://github.com/saulopef/desafio_mobile.git`

 2. Abra a pasta "desafio_mobile_bycoders" na IDE de sua preferencia
> Testado e aprovado utilizando Visual Studio Code IDE com framework flutter e dart instalados na maquina

 3. Para rodar a aplicação pressione F5, ou utilize o comando:
 `Flutter run`

# Usuários de Testes:

> email: bycoders@testemobile.com | senha: 123456
> email: usuariobycoder@teste.com | senha: 654321

 # Unit testing and e2e
 
 1. Para executar os testes Unitários, abra a pasta tests e no arquivo **unit_tests.dart** pressione o comando run (logo acima da main).
![Run Unit Test](https://i.ibb.co/cK5Jsgm/image.png)

 2. Para executar os Integrations tests use o comando:
> flutter drive  --driver=test_driver/integration_test_driver.dart  --target=integration_test/app_test.dart

As ações de sucesso ou erro são devidamente enviadas ao Analytics de minha conta pessoal, assim como as exceções serão enviadas ao Crashlytics!

 - Caso deseje gerar uma Exceção para testes
1. Vá até  `lib>login>controller>login_controller.dart`
2. Remova o comentário da **linha 34**:
> // FirebaseCrashlytics.instance.crash();
> 
> ====> Deve Ficar assim: <====
> 
>  FirebaseCrashlytics.instance.crash();
>  
3. A proxima vez que precionar o botão de login, um erro de testes será gerado e o app ira crashar; 
 
*Foram realizadas todas as integrações visando as plataformas **Android** e **IOS**, porem os recursos estão otimizados para Android por conta dos recursos durante este desenvolvimento*
