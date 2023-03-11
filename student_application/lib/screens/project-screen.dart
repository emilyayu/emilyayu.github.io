import 'package:flutter/material.dart';

import '../models/project.dart';

class ProjectScreen extends StatelessWidget {
  static const routeName = '/project';

  String ProjectName = "Mapping the blackberry";
  String ProjectType = "Image and Geolocation";
  String ProjectDescription = "An invasive species is an organism that is not "
      "indigenous, or native to a particular area. To be considered invasive it "
      "must harm property, the economy, or native plants and animals in the region. "
      "As a community we can help stop the spread of these species!";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
            child: Card(
                margin: EdgeInsets.all(20.0),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 150,
                          backgroundImage: NetworkImage(
                              'https://storage.googleapis.com/project-image-bucket/blackberry.jpg'),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                              child: ListTile(
                                title: Text(ProjectName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall),
                                subtitle: Text(ProjectType,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                              child: ListTile(
                                title: Text('Project Description',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium),
                                subtitle: Text(
                                  ProjectDescription,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              )
            ));
  }
}
